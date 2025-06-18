<%@ page import="java.sql.*" %>
<%
    String medicineCategory = request.getParameter("medicineCategory");
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Medicine Report by Category</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                padding: 20px;
            }
            table {
                width: 100%;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Medicine Report by Category</h2>
            <table class="table table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Medicine ID</th>
                        <th>Medicine Name</th>
                        <th>Medicine Category</th>
                        <th>Medicine Stock</th>
                        <th>Medicine Price</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                         Class.forName("com.mysql.cj.jdbc.Driver");
             conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM medicine WHERE medicine_Category='" + medicineCategory + "'";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("medicine_ID") %></td>
                        <td><%= rs.getString("medicine_Name") %></td>
                        <td><%= rs.getString("medicine_Category") %></td>
                        <td><%= rs.getInt("medicine_Stock") %></td>
                        <td><%= rs.getDouble("medicine_Price") %></td>
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
                </tbody>
            </table>
        </div>
    </body>
</html>
