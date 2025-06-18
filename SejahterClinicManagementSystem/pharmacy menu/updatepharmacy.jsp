<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Pharmacy Profile</title>
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
            .form-container label {
                margin: 5px 0 0;
                color: #333;
            }
            .form-container input[type="text"],
            .form-container input[type="submit"],
            .form-container button {
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
            .form-container button {
                background-color: #f4f4f4;
                color: #333;
                border: none;
            }
            .form-container button:hover {
                background-color: #e7e7e7;
            }
        </style>
    </head>
    <body>
        <%
            Connection con = null;
            Statement s = null;
            String id = (String) session.getAttribute("loginID");
            System.out.println("Received loginID: " + id);  // Debugging statement

            try {
                 Class.forName("com.mysql.cj.jdbc.Driver");
             con = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");
                s = con.createStatement();
                String sql = "SELECT * FROM employee WHERE employee_loginID='" + id + "'";
                System.out.println("SQL Query: " + sql);  // Debugging statement

                ResultSet rs = s.executeQuery(sql);

                if (!rs.next()) {
                    out.println("Sorry, could not find that publisher.");
                } else {
        %>
        <div class="form-container">
            <h2>Update Doctor Profile</h2>
            <form action="updateprofileaction.jsp" method="post">
                <input type="hidden" id="ic" name="ic" value="<%=rs.getString("employee_IC")%>">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%=rs.getString("employee_Name")%>" readonly>
                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phoneNumber" value="<%=rs.getString("employee_PhoneNumber")%>">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%=rs.getString("employee_Address")%>">
                <input type="submit" value="Update Profile">
            </form>
            <button onclick="location.href = 'pharmacymenu.jsp'">Back to Menu</button>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (s != null) s.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </body>
</html>

