package web.bean.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class OracleConnection {
    public static Connection getConnection() {
         Connection conn = null;
         try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String dbURL = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
            String user = "project02";
            String dbpw = "project02";
            conn = DriverManager.getConnection(dbURL, user, dbpw);
         } catch(Exception e) {
            e.printStackTrace();
         }
         return conn;
      }
      
      public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
         if(rs != null) {try{rs.close();} catch(SQLException s) {s.printStackTrace();}}
         if(pstmt != null) {try{pstmt.close();} catch(SQLException s) {s.printStackTrace();}}
         if(conn != null) {try{conn.close();} catch(SQLException s) {s.printStackTrace();}}
      }
}