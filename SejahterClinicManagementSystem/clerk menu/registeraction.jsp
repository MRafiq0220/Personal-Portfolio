<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String ic = request.getParameter("ic");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String dob = request.getParameter("dob");
    String position = request.getParameter("position");
    String loginId = request.getParameter("login_id");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    Connection conn = null;
    PreparedStatement pstmtLogin = null;
    PreparedStatement pstmtEmployee = null;

    if (!password.equals(confirmPassword)) {
%>
<div class="alert alert-danger" role="alert">
    Passwords do not match. Please try again.
</div>
<%
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

            // Insert into login table
            String sqlLogin = "INSERT INTO login (login_loginID, login_password) VALUES (?, ?)";
            pstmtLogin = conn.prepareStatement(sqlLogin);
            pstmtLogin.setString(1, loginId);
            pstmtLogin.setString(2, password);
            pstmtLogin.executeUpdate();

            // Insert into employee table
            String sqlEmployee = "INSERT INTO employee (employee_IC, employee_Name, employee_Gender, employee_PhoneNumber, employee_Address, employee_DateOfBirth, employee_Position, employee_loginID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmtEmployee = conn.prepareStatement(sqlEmployee);
            pstmtEmployee.setString(1, ic);
            pstmtEmployee.setString(2, name);
            pstmtEmployee.setString(3, gender);
            pstmtEmployee.setString(4, phone);
            pstmtEmployee.setString(5, address);
            pstmtEmployee.setDate(6, Date.valueOf(dob));
            pstmtEmployee.setString(7, position);
            pstmtEmployee.setString(8, loginId);
            pstmtEmployee.executeUpdate();
%>
<div class="alert alert-success" role="alert">
    Account registered successfully! Redirecting to login page...
</div>
<%
            response.setHeader("Refresh", "3; URL=login.html");  // Redirect to login.html after 3 seconds
        } catch (SQLException e) {
            // Log the error and show a generic message to the user
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            System.err.println("SQL Exception: " + e.getMessage());
            out.println("<div class='alert alert-danger' role='alert'>An error occurred. Please try again later.</div>");
        } catch (ClassNotFoundException e) {
            // Log the error and show a generic message to the user
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            System.err.println("ClassNotFoundException: " + e.getMessage());
            out.println("<div class='alert alert-danger' role='alert'>An error occurred. Please try again later.</div>");
        } finally {
            try { if (pstmtLogin != null) pstmtLogin.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmtEmployee != null) pstmtEmployee.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
