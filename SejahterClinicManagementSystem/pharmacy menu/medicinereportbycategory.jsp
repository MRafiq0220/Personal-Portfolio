<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Medicine Report by Category</title>
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
            .report-container h3 {
                color: #28a745;
                margin-top: 20px;
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
            .form-container {
                text-align: center;
                margin-bottom: 20px;
            }
            .form-container select, .form-container input[type="submit"] {
                padding: 10px;
                font-size: 16px;
                margin: 5px;
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
        <div class="report-container">
            <h2>Medicine Report by Category</h2>
            <div class="form-container">
                <form action="medicinereportbycategory.jsp" method="get">
                    <select name="category" required>
                        <option value="">Select Category</option>
                        <option value="D">Fever (D)</option>
                        <option value="A">Antibiotic (A)</option>
                        <option value="S">Cold (S)</option>
                        <option value="SF">Nervous (SF)</option>
                        <option value="TS">Pain Relief (TS)</option>
                    </select>
                    <input type="submit" value="Get Report">
                </form>
            </div>
            <%
                String category = request.getParameter("category");
                if (category != null && !category.isEmpty()) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                        String sql = "SELECT medication_Code, medication_Name, medication_Price " +
                                     "FROM medication " +
                                     "WHERE medication_Category = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, category);
                        rs = pstmt.executeQuery();
            %>
            <h3>Category: <%= category %></h3>
            <table>
                <tr>
                    <th>Medicine ID</th>
                    <th>Medicine Name</th>
                    <th>Price</th>
                </tr>
                <%
                            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("medication_Code") %></td>
                    <td><%= rs.getString("medication_Name") %></td>
                    <td>RM<%= rs.getDouble("medication_Price") %></td>
                </tr>
                <%
                            }
                %>
            </table>
            <a href="reportmenu.jsp" class="back-button">Back</a>
            <%
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error retrieving medicine report by category: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            %>
        </div>
    </body>
</html>
