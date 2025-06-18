<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Register Treatment</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .form-container {
                width: 300px;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .form-container h2 {
                text-align: center;
                color: #333;
            }
            .form-container form {
                display: flex;
                flex-direction: column;
            }
            .form-container input[type="text"],
            .form-container select,
            .form-container textarea,
            .form-container input[type="submit"] {
                margin: 10px 0;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .form-container input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
            }
            .form-container input[type="submit"]:hover {
                background-color: #45a049;
            }
            .form-container .back-button {
                background-color: #f4f4f4;
                color: black;
                border: 1px solid #ccc;
                text-align: center;
                text-decoration: none;
                padding: 10px;
                border-radius: 5px;
                margin-top: 10px;
            }
            .form-container .back-button:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Register Treatment</h2>
            <form action="registertreatmentaction.jsp" method="post">
                <label for="patientIC">Patient IC:</label>
                <input type="text" id="patientIC" name="patientIC" required><br>
                <label for="doctorID">Doctor ID:</label>
                <select id="doctorID" name="doctorID" required>
                    <option value="">Select Doctor</option>
                    <%
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    con = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                            stmt = con.createStatement();
                            String sql = "SELECT employee_IC, employee_Name FROM employee WHERE employee_loginID LIKE 'D%'";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                String doctorID = rs.getString("employee_IC");
                                String doctorName = rs.getString("employee_Name");
                    %>
                    <option value="<%=doctorID%>"><%=doctorName%> (<%=doctorID%>)</option>
                    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
                    %>
                </select><br>
                <label for="treatmentDescription">Treatment Description:</label>
                <textarea id="treatmentDescription" name="treatmentDescription" required></textarea><br>
                <input type="submit" value="Register">
            </form>
            <br>
            <a href="clerkmenu.jsp" class="back-button">Back</a>
        </div>
    </body>
</html>
