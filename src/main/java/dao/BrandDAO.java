package dao;


import bean.Brand;
import util.DataBaseUtil;
import util.Page;
import util.StrUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {

    public void addBrand(Brand brand) throws SQLException {

        String sql = "INSERT INTO brand (sort, brand_name, description) VALUES (?,?,?)";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, brand.getSort());
            preparedStatement.setString(2, brand.getBrandName());
            preparedStatement.setString(3, brand.getDescription());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw e;
        }
    }

    public Brand getBrandById(int id) {

        String sql = "SELECT * FROM brand WHERE id =?";
        Brand brand = null;
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    brand = new Brand();
                    brand.setId(resultSet.getInt("id"));
                    brand.setSort(resultSet.getInt("sort"));
                    brand.setBrandName(resultSet.getString("brand_name"));
                    brand.setDescription(resultSet.getString("description"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brand;
    }

    public void updateBrand(Brand brand) throws SQLException {
        String sql = "UPDATE brand SET sort = ?, brand_name = ?, description = ? WHERE id = ?";

        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, brand.getSort());
            preparedStatement.setString(2, brand.getBrandName());
            preparedStatement.setString(3, brand.getDescription());
            preparedStatement.setInt(4, brand.getId());
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No rows updated, the brand with id " + brand.getId() + " may not exist.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void deleteBrand(int id) {

        String sql = "DELETE FROM brand WHERE id =?";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Brand> getAllBrands() {

        String sql = "SELECT * FROM brand";
        List<Brand> brandList = new ArrayList<>();
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Brand brand = new Brand();
                brand.setId(resultSet.getInt("id"));
                brand.setSort(resultSet.getInt("sort"));
                brand.setBrandName(resultSet.getString("brand_name"));
                brand.setDescription(resultSet.getString("description"));
                brandList.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brandList;
    }

    public Page<Brand> getAllBrandsPage(Integer pageNo, Integer pageSize,String searchInput,String sortOrder) {
        Page p=new Page().setPageNo(pageNo).setPageSize(pageSize);



        String sqlCount = "select count(1) num from brand where 1=1 "+(StrUtil.isBlank(searchInput)?"":" and Brand_Name like '%"+searchInput+"%' ");
        if("1".equals(sortOrder)) {
            sortOrder =   " order by id desc";
        }else{
            sortOrder = " order by id asc";
        }
        String sqlSelect = "select * from brand where 1=1 "+(StrUtil.isBlank(searchInput)?"":" and Brand_Name like '%"+searchInput+"%'  ")+String.format(sortOrder+" limit %s,%s",(pageNo-1)*pageSize,pageSize);
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

            List<Brand> brandList = new ArrayList<>();
            ResultSet resultSet = preparedStatementSelect.executeQuery();
            while (resultSet.next()) {
                Brand brand = new Brand();
                brand.setId(resultSet.getInt("id"));
                brand.setSort(resultSet.getInt("sort"));
                brand.setBrandName(resultSet.getString("brand_name"));
                brand.setDescription(resultSet.getString("description"));
                brandList.add(brand);
            }
            p.setList(brandList);

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


    public static void main(String[] args) {
        BrandDAO brandDAO = new BrandDAO();
        Brand brand = brandDAO.getBrandById(1);
        System.out.println(brand.getBrandName());
    }
}