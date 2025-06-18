<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>All Medicine Report</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #e9f7ef;
            }
            .report-container {
                width: 80%;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 10px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .report-container h2 {
                text-align: center;
                color: #28a745;
            }
            .report-container table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            .report-container th, .report-container td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            .report-container th {
                background-color: #28a745;
                color: white;
            }
            .back-button {
                display: block;
                width: 100px;
                margin: 20px auto;
                padding: 10px;
                text-align: center;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
               Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
             conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");
                // Query to join medication and stockmedication tables
                String sql = "SELECT medication_Code, medication_Name, medication_Category, medication_Price, stockMedication_Quantity " +
                             "FROM medication " +
                             "JOIN stockmedication ON medication_Code = stockMedication_medicationCode";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
        %>
        <div class="report-container">
            <h2>All Medicine Report</h2>
            <table>
                <tr>
                    <th>Medicine ID</th>
                    <th>Medicine Name</th>
                    <th>Category</th>
                    <th>Price</th>
                </tr>
                <%
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("medication_Code") %></td>
                    <td><%= rs.getString("medication_Name") %></td>
                    <td><%= rs.getString("medication_Category") %></td>
                    <td>RM<%= rs.getDouble("medication_Price") %></td>
                </tr>
                <%
                        }
                %>
            </table>
            <a href="reportmenu.jsp" class="back-button">Back</a>
        </div>
        <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error retrieving all medicine report: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </body>
</html>
