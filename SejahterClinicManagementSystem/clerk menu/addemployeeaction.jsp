<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String ic = request.getParameter("ic");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String role = request.getParameter("role");
    String loginID = request.getParameter("loginID");
    String password = request.getParameter("password"); // Assuming password is also passed

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    } catch (ClassNotFoundException e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("MySQL JDBC Driver not found. Include it in your library path.<br>" + sw.toString());
        return;
    }

    try {
        // Establish the connection to the database
        conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        // Insert login details into login table
        String loginSql = "INSERT INTO login (login_loginID, login_password) VALUES (?, ?)";
        pstmt = conn.prepareStatement(loginSql);
        pstmt.setString(1, loginID);
        pstmt.setString(2, password);

        int loginRowsInserted = pstmt.executeUpdate();

        if (loginRowsInserted > 0) {
            // Close previous statement
            pstmt.close();

            // Insert employee details
            String sql = "INSERT INTO employee (employee_IC, employee_Name, employee_Gender, employee_PhoneNumber, employee_DateOfBirth, employee_Address, employee_Position, employee_loginID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, ic);
            pstmt.setString(2, name);
            pstmt.setString(3, gender);
            pstmt.setString(4, phone);
            pstmt.setDate(5, Date.valueOf(dob)); // Convert to SQL date
            pstmt.setString(6, address);
            pstmt.setString(7, role);
            pstmt.setString(8, loginID);

            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                out.println("Employee added successfully!");
                response.sendRedirect("clerkmenu.jsp");
            } else {
                out.println("Failed to add employee.");
            }
        } else {
            out.println("Failed to add login details.");
        }

    } catch (SQLException e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("SQL Exception: " + e.getMessage() + "<br>" + sw.toString());
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { 
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            out.println(sw.toString());
        }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { 
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            out.println(sw.toString());
        }
        try { if (conn != null) conn.close(); } catch (SQLException e) { 
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            out.println(sw.toString());
        }
    }
%>
