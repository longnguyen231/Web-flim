/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Country;


/**
 *
 * @author Long
 */
public class CountriesDao extends DBContext{
    
    public List<Country> getAllCountries() {
    List<Country> countries = new ArrayList<>();
    String sql = "SELECT * FROM [Countries]";
    try {
        PreparedStatement stm = DBContext.getConnection().prepareCall(sql);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Country country = new Country();
            country.setCode(rs.getString("CountryCode"));
            country.setCountryName(rs.getString("CountryName"));
            countries.add(country);
        }
    } catch (SQLException ex) {
        Logger.getLogger(CountriesDao.class.getName()).log(Level.SEVERE, null, ex);
    }
    return countries;
}

}
