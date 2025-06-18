<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Retrieve Employee</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .container {
                width: 50%;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .container h2 {
                text-align: center;
                color: #333;
            }
            .container table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            .container th, .container td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            .container th {
                background-color: #4CAF50;
                color: white;
            }
            .container form {
                text-align: center;
                margin: 20px 0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Retrieve Employee</h2>
            <form action="retrieveemployee.jsp" method="get">
                <label for="employeeIC">Enter Employee IC:</label>
                <input type="text" id="employeeIC" name="employeeIC" required>
                <input type="submit" value="Retrieve">
            </form>
            <%
                String employeeIC = request.getParameter("employeeIC");
                if (employeeIC != null && !employeeIC.isEmpty()) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");


                        String sql = "SELECT * FROM employee WHERE employee_IC = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, employeeIC);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
            %>
            <table>
                <tr>
                    <th>Employee IC</th>
                    <td><%= rs.getString("employee_IC") %></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><%= rs.getString("employee_Name") %></td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td><%= rs.getString("employee_Gender") %></td>
                </tr>
                <tr>
                    <th>Phone Number</th>
                    <td><%= rs.getString("employee_PhoneNumber") %></td>
                </tr>
                <tr>
                    <th>Date of Birth</th>
                    <td><%= rs.getDate("employee_DateOfBirth") %></td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td><%= rs.getString("employee_Address") %></td>
                </tr>
                <tr>
                    <th>Position</th>
                    <td><%= rs.getString("employee_Position") %></td>
                </tr>
                <tr>
                    <th>Login ID</th>
                    <td><%= rs.getString("employee_loginID") %></td>
                </tr>
            </table>
            <form action="deleteemployee.jsp" method="post">
                <input type="hidden" name="employeeIC" value="<%= employeeIC %>">
                <input type="submit" value="Delete Employee">
            </form>
            <%
                        } else {
                            out.println("<p>Employee not found.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error retrieving employee information: " + e.getMessage() + "</p>");
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
