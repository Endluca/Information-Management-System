package dao;

import bean.Vip;
import util.DataBaseUtil;
import util.Page;
import util.StrUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VipDAO {

    public void addVip(Vip vip) throws SQLException {

        String sql = "INSERT INTO vip (username, gender, phone, email, address) VALUES (?,?,?,?,?)";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, vip.getUsername());
            preparedStatement.setString(2, vip.getGender());
            preparedStatement.setString(3, vip.getPhone());
            preparedStatement.setString(4, vip.getEmail());
            preparedStatement.setString(5, vip.getAddress());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw e;
        }
    }

    public Vip getVipById(int id) {

        String sql = "SELECT * FROM vip WHERE id =?";
        Vip vip = null;
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    vip = new Vip();
                    vip.setId(resultSet.getInt("id"));
                    vip.setUsername(resultSet.getString("username"));
                    vip.setGender(resultSet.getString("gender"));
                    vip.setPhone(resultSet.getString("phone"));
                    vip.setEmail(resultSet.getString("email"));
                    vip.setAddress(resultSet.getString("address"));
                    vip.setCreatedTime(resultSet.getTimestamp("createdTime"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vip;
    }

    public void updateVip(Vip vip) throws SQLException {

        String sql = "UPDATE vip SET username =?, gender =?, phone =?, email =?, address =? WHERE id =? ";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, vip.getUsername());
            preparedStatement.setString(2, vip.getGender());
            preparedStatement.setString(3, vip.getPhone());
            preparedStatement.setString(4, vip.getEmail());
            preparedStatement.setString(5, vip.getAddress());
            preparedStatement.setInt(6, vip.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw e;
        }
    }
    public void deleteVipByIsDeleted(int id) {

        String sql = "UPDATE vip SET is_deleted = 'yes' WHERE id =?";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }public void deleteVip(int id) {

        String sql = "delete from vip WHERE id =?";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Vip> getAllVips() {

        String sql = "SELECT * FROM vip where is_deleted = 'no'";
        List<Vip> vipList = new ArrayList<>();
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Vip vip = new Vip();
                vip.setId(resultSet.getInt("id"));
                vip.setUsername(resultSet.getString("username"));
                vip.setGender(resultSet.getString("gender"));
                vip.setPhone(resultSet.getString("phone"));
                vip.setEmail(resultSet.getString("email"));
                vip.setAddress(resultSet.getString("address"));
                vip.setCreatedTime(resultSet.getTimestamp("createdTime"));
                vip.setIsDeleted(resultSet.getString("is_deleted"));
                vipList.add(vip);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vipList;
    }
    public Page<Vip> getAllVipsPage(Integer pageNo, Integer pageSize,String searchInput,String sortOrder) {
        Page p=new Page().setPageNo(pageNo).setPageSize(pageSize);

        String sqlCount = "select count(1) num from vip where 1=1 and is_deleted!='yes' "+(StrUtil.isBlank(searchInput)?"":" and username like '%"+searchInput+"%' ");;
        if("1".equals(sortOrder)) {
            sortOrder =   " order by id desc";
        }else{
            sortOrder = " order by id asc";
        }
        String sqlSelect = "select * from vip where 1=1 and is_deleted!='yes' "+(StrUtil.isBlank(searchInput)?"":" and username like '%"+searchInput+"%' ")+String.format(sortOrder+" limit %s,%s",(pageNo-1)*pageSize,pageSize);
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

            List<Vip> list = new ArrayList<>();
            ResultSet resultSet = preparedStatementSelect.executeQuery();
            while (resultSet.next()) {
                Vip vip = new Vip();
                vip.setId(resultSet.getInt("id"));
                vip.setUsername(resultSet.getString("username"));
                vip.setGender(resultSet.getString("gender"));
                vip.setPhone(resultSet.getString("phone"));
                vip.setEmail(resultSet.getString("email"));
                vip.setAddress(resultSet.getString("address"));
                vip.setCreatedTime(resultSet.getTimestamp("createdTime"));
                vip.setIsDeleted(resultSet.getString("is_deleted"));
                list.add(vip);
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

    public List<Vip> getAllVips2() {

        String sql = "SELECT * FROM vip";
        List<Vip> vipList = new ArrayList<>();
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Vip vip = new Vip();
                vip.setId(resultSet.getInt("id"));
                vip.setUsername(resultSet.getString("username"));
                vip.setGender(resultSet.getString("gender"));
                vip.setPhone(resultSet.getString("phone"));
                vip.setEmail(resultSet.getString("email"));
                vip.setAddress(resultSet.getString("address"));
                vip.setCreatedTime(resultSet.getTimestamp("createdTime"));
                vip.setIsDeleted(resultSet.getString("is_deleted"));
                vipList.add(vip);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vipList;
    }
    public Page<Vip> getAllVips2Page(Integer pageNo, Integer pageSize,String searchInput) {
        Page p=new Page().setPageNo(pageNo).setPageSize(pageSize);

        String sqlCount = "select count(1) num from vip where is_deleted!='否' "+(StrUtil.isBlank(searchInput)?"":" and username like '%"+searchInput+"%' ");
        String sqlSelect = "select * from vip where is_deleted!='否' "+(StrUtil.isBlank(searchInput)?"":" and username like '%"+searchInput+"%' ")+  String.format(" limit %s,%s",(pageNo-1)*pageSize,pageSize);
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

            List<Vip> list = new ArrayList<>();
            ResultSet resultSet = preparedStatementSelect.executeQuery();
            while (resultSet.next()) {
                Vip vip = new Vip();
                vip.setId(resultSet.getInt("id"));
                vip.setUsername(resultSet.getString("username"));
                vip.setGender(resultSet.getString("gender"));
                vip.setPhone(resultSet.getString("phone"));
                vip.setEmail(resultSet.getString("email"));
                vip.setAddress(resultSet.getString("address"));
                vip.setCreatedTime(resultSet.getTimestamp("createdTime"));
                vip.setIsDeleted(resultSet.getString("is_deleted"));
                list.add(vip);
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

    public boolean isExistByUsername(String username) {
        boolean isExist = false;

        String sql = "SELECT * FROM vip where is_deleted = 'no' and username = ?";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                isExist = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isExist;
    }

    public static void main(String[] args) {
        VipDAO vipDAO = new VipDAO();
        boolean janeSmith = vipDAO.isExistByUsername("Jane Smith");
        System.out.println(janeSmith);
    }
}