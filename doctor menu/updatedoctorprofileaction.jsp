<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String username = request.getParameter("ic"); // This should be retrieved from the session
    String phoneNumber = request.getParameter("phoneNumber");
    String address = request.getParameter("address");

    if (username == null || username.isEmpty() || phoneNumber == null || phoneNumber.isEmpty() || address == null || address.isEmpty()) {
        out.println("<script>alert('All fields are required'); window.location.href='updatedoctorprofile.jsp';</script>");
        return;
    }

    Connection conn = null;
    Statement stmt = null;

    try {
       Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
       conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        stmt = conn.createStatement();
        String sql = "UPDATE employee SET employee_PhoneNumber='" + phoneNumber + "', employee_Address='" + address + "' WHERE employee_IC='" + username + "'";
        
        int result = stmt.executeUpdate(sql);

        if (result > 0) {
            out.println("<script>alert('Profile updated successfully'); window.location.href='updatedoctorprofile.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to update profile'); window.location.href='updatedoctorprofile.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace(new PrintWriter(out));  // Print stack trace to the JSP output
        out.println("<script>alert('Error updating profile. Check the console for details.');</script>");
    } finally {
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(new PrintWriter(out)); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(new PrintWriter(out)); }
    }
%>
