
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {


    private static final String URL = "jdbc:sqlserver://localhost:1433;" +
     "databaseName=Assgn_PRJ_WEB_T_Xem_Phim;" +
     "encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa";
    private static final String PASS = "123";


    public static Connection getConnection() {
        Connection connection = null;
        String url = DBContext.URL;
        String user = DBContext.USER;
        String pass = DBContext.PASS;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
            System.out.println("Connect success!!!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }

        return connection;
    }

    public static void main(String[] args) {
        Connection connection = DBContext.getConnection();
        if (connection != null) {
            System.out.println("Connection successful!");
            try {
                // Do something with the connection here if needed
                // For example, you can execute queries or perform database operations
                // Remember to close the connection when finished
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            System.out.println("Failed to connect to the database.");
        }
    }
}
