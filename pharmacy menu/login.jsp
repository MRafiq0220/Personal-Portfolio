<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
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
        // Log the error and show a generic message to the user
        System.err.println("MySQL JDBC Driver not found. Include it in your library path.");
        out.println("Internal error. Please try again later.");
        return;
    }

    try {
        // Establish the connection to the database
conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");
    } catch (SQLException e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        // Log the error and show a generic message to the user
        System.err.println("Connection to database failed: " + e.getMessage());
        out.println("Internal error. Please try again later.");
        return;
    }

    try {
        if (conn != null) {
            String sql = "SELECT login_loginID, login_password FROM login WHERE login_loginID=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String loginID = rs.getString("login_loginID");
                String storedPassword = rs.getString("login_password");

                if (password.equals(storedPassword)) {
                    // Use the existing session object
                    session.setAttribute("loginID", loginID);

                    char role = loginID.charAt(0);

                    switch (role) {
                        case 'K':
                            response.sendRedirect("clerk/clerkmenu.jsp");
                            break;
                        case 'D':
                            response.sendRedirect("doctor/doctormenu.jsp");
                            break;
                        case 'F':
                            response.sendRedirect("pharmacy/pharmacymenu.jsp");
                            break;
                        default:
                            out.println("Unknown role.");
                            break;
                    }
                } else {
                    out.println("Invalid username or password.");
                }
            } else {
                out.println("Invalid username or password.");
            }
        }
    } catch (SQLException e) {
        // Log the error and show a generic message to the user
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        System.err.println("SQL Exception: " + e.getMessage());
        out.println("Internal error. Please try again later.");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
