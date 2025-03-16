package dao;

import bean.Role;
import util.DataBaseUtil;
import util.Page;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {

    public void addRole(Role role) {

        String sql = "INSERT INTO role (role_name, description) VALUES (?,?)";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, role.getRoleName());
            preparedStatement.setString(2, role.getDescription());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public Role getRoleById(int id) throws SQLException {

        String sql = "SELECT * FROM role WHERE id =?";
        Role role = null;
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    role = new Role();
                    role.setId(resultSet.getInt("id"));
                    role.setRoleName(resultSet.getString("role_name"));
                    role.setDescription(resultSet.getString("description"));
                    role.setCreatedTime(resultSet.getTimestamp("created_time"));
                }
            }
        } catch (SQLException e) {
            throw e;
        }
        return role;
    }

    public void updateRole(Role role) throws SQLException {
        String sql = "UPDATE role SET role_name =?, description =? WHERE id =?";

        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, role.getRoleName());
            preparedStatement.setString(2, role.getDescription());
            preparedStatement.setInt(3, role.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw e;
        }

    }


    public void deleteRole(int id) {

        String sql = "DELETE FROM role WHERE id =?";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Role> getAllRoles() {

        String sql = "SELECT * FROM role";
        List<Role> roleList = new ArrayList<>();
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Role role = new Role();
                role.setId(resultSet.getInt("id"));
                role.setRoleName(resultSet.getString("role_name"));
                role.setDescription(resultSet.getString("description"));
                role.setCreatedTime(resultSet.getTimestamp("created_time"));
                roleList.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roleList;
    }
    public Page<Role> getAllRolesPage(Integer pageNo, Integer pageSize,String sortOrder) {
        Page p=new Page().setPageNo(pageNo).setPageSize(pageSize);

        String sqlCount = "select count(1) num from role";
        if("1".equals(sortOrder)) {
            sortOrder =   " order by id desc";
        }else{
            sortOrder = " order by id asc";
        }
        String sqlSelect = String.format("select * from role "+sortOrder+" limit %s,%s",(pageNo-1)*pageSize,pageSize);
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

            List<Role> list = new ArrayList<>();
            ResultSet resultSet = preparedStatementSelect.executeQuery();

            while (resultSet.next()) {
                Role role = new Role();
                role.setId(resultSet.getInt("id"));
                role.setRoleName(resultSet.getString("role_name"));
                role.setDescription(resultSet.getString("description"));
                role.setCreatedTime(resultSet.getTimestamp("created_time"));
                list.add(role);
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


}