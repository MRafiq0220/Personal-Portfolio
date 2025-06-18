<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
    <head>
        <title>View Patients</title>
    </head>
    <body>
        <h2>Patients List</h2>
        <table border="1">
            <tr>
                <th>IC</th>
                <th>Name</th>
                <th>Phone Number</th>
                <th>Address</th>
            </tr>
            <%
                try {
              Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
           conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM patient";
                    rs = stmt.executeQuery(sql);
                    while (rs.next()) {
                        String ic = rs.getString("patient_IC");
                        String name = rs.getString("patient_Name");
                        String phoneNumber = rs.getString("patient_PhoneNumber");
                        String address = rs.getString("patient_Address");
            %>
            <tr>
                <td><%= ic %></td>
                <td><%= name %></td>
                <td><%= phoneNumber %></td>
                <td><%= address %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </table>
    </body>
</html>
